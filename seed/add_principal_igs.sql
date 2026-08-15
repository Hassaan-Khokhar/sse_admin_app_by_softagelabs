-- ============================================================================
--  ADD / BOOTSTRAP USER · principal@igs.edu.pk
--  Run in: Supabase dashboard → SQL Editor, on project `sse_portal`
--  Role: super_admin (Principal)
--  Password: 12345
--
--  Safe to run more than once (idempotent).
-- ============================================================================

-- Step 1: Ensure pgcrypto extension is available for bcrypt password hashing
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Step 2: Create auth.users entry directly with password '12345'
-- (Or if already created, updates the password and confirms email)
DO $$
DECLARE
    v_user_id uuid;
    v_school_id uuid := 'e05fe3c2-de30-513c-9fbb-125aefaa707a';
    v_email text := 'principal@igs.edu.pk';
    v_password text := '12345';
BEGIN
    -- Check if user already exists in auth.users
    SELECT id INTO v_user_id FROM auth.users WHERE email = v_email;

    IF v_user_id IS NULL THEN
        v_user_id := gen_random_uuid();
        
        INSERT INTO auth.users (
            instance_id,
            id,
            aud,
            role,
            email,
            encrypted_password,
            email_confirmed_at,
            raw_app_meta_data,
            raw_user_meta_data,
            created_at,
            updated_at,
            confirmation_token,
            email_change,
            email_change_token_new,
            recovery_token
        ) VALUES (
            '00000000-0000-0000-0000-000000000000',
            v_user_id,
            'authenticated',
            'authenticated',
            v_email,
            crypt(v_password, gen_salt('bf')),
            now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Principal"}'::jsonb,
            now(),
            now(),
            '',
            '',
            '',
            ''
        );
    ELSE
        -- Update password and ensure email is confirmed
        UPDATE auth.users
        SET encrypted_password = crypt(v_password, gen_salt('bf')),
            email_confirmed_at = COALESCE(email_confirmed_at, now()),
            updated_at = now()
        WHERE id = v_user_id;
    END IF;

    -- Ensure School exists
    INSERT INTO public.schools (id, name, address, phone, updated_at)
    VALUES (
        v_school_id,
        'Islamabad Grammar School',
        'Model Town, Lahore',
        '042-35880000',
        now()
    )
    ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, updated_at = now();

    -- Ensure Academic Year exists
    INSERT INTO public.academic_years
        (id, school_id, name, start_date, end_date, is_current, updated_at)
    VALUES (
        '497e12ee-ade7-534b-a1ef-29298e30b3bb',
        v_school_id,
        '2026-2027', '2026-04-01', '2027-03-31', true, now()
    )
    ON CONFLICT (id) DO UPDATE SET is_current = true, updated_at = now();

    -- Ensure Seed Principal (for foreign keys in historical seed data)
    INSERT INTO public.app_users (id, school_id, role, full_name, is_active, updated_at)
    VALUES (
        'fcbad286-6a85-5964-ab97-a79282ee21c7',
        v_school_id,
        'super_admin',
        'Principal (seed)',
        true,
        now()
    )
    ON CONFLICT (id) DO UPDATE SET is_active = true, updated_at = now();

    -- Link auth account to app_users as super_admin
    INSERT INTO public.app_users (id, school_id, role, email, full_name, is_active, updated_at)
    VALUES (
        v_user_id,
        v_school_id,
        'super_admin',
        v_email,
        'Principal',
        true,
        now()
    )
    ON CONFLICT (id) DO UPDATE
        SET role = 'super_admin', email = v_email, is_active = true, updated_at = now();

END $$;

-- Verify account creation
SELECT a.full_name,
       a.role,
       a.email,
       (u.id IS NOT NULL) AS linked_to_auth
FROM public.app_users a
LEFT JOIN auth.users u ON u.id = a.id
WHERE a.email = 'principal@igs.edu.pk';
