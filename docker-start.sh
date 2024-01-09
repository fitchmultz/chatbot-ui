#!/bin/bash

# Start Supabase in the background and capture the output
SUPABASE_OUTPUT=$(supabase start)

# Wait for Supabase to be ready (you may need to adjust the sleep duration)
sleep 10

# Extract the API URL, anon key, and service_role key from the output
export NEXT_PUBLIC_SUPABASE_URL=$(echo "$SUPABASE_OUTPUT" | grep 'API URL' | awk '{print $3}')
export NEXT_PUBLIC_SUPABASE_ANON_KEY=$(echo "$SUPABASE_OUTPUT" | grep 'anon key' | awk '{print $3}')
export SUPABASE_SERVICE_ROLE_KEY=$(echo "$SUPABASE_OUTPUT" | grep 'service_role key' | awk '{print $3}')

# If the variables are not set, use the default values
export NEXT_PUBLIC_SUPABASE_URL=${NEXT_PUBLIC_SUPABASE_URL:-"http://localhost:54321"}
export NEXT_PUBLIC_SUPABASE_ANON_KEY=${NEXT_PUBLIC_SUPABASE_ANON_KEY:-"your_default_anon_key"}
export SUPABASE_SERVICE_ROLE_KEY=${SUPABASE_SERVICE_ROLE_KEY:-"your_default_service_role_key"}

# Start your app
npm run chat
