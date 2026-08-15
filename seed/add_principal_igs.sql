-- ============================================================================
--  ADD / BOOTSTRAP USER · principal@igs.edu.pk
--  Run in: Supabase dashboard → SQL Editor, on project `sse_portal`
--  Role: super_admin (Principal)
--  Password: 12345
--
--  This creates a SEPARATE school from the sunrise demo data.
--  The IGS principal sees only their own school's data via RLS.
--
--  Safe to run more than once (idempotent).
-- ============================================================================

-- Step 1: Ensure pgcrypto extension is available for bcrypt password hashing
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Step 2: Create auth.users entry + school + app_users
DO $$
DECLARE
    v_user_id uuid;
    v_school_id uuid := '8fb9763b-b4eb-43ce-b426-26bb8484aaac';
    v_year_id  uuid := 'cc891916-6fc2-40a2-bd4a-580df4c8b44c';
    v_email text := 'principal@igs.edu.pk';
    v_password text := '12345';
BEGIN
    -- ── Auth account ────────────────────────────────────────────────────
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

    -- ── School (separate from sunrise demo) ─────────────────────────────
    INSERT INTO public.schools (id, name, address, phone, updated_at)
    VALUES (
        v_school_id,
        'Islamabad Grammar School',
        'Islamabad',
        '051-1234567',
        now()
    )
    ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, updated_at = now();

    -- ── Academic Year ───────────────────────────────────────────────────
    INSERT INTO public.academic_years
        (id, school_id, name, start_date, end_date, is_current, updated_at)
    VALUES (
        v_year_id,
        v_school_id,
        '2026-2027', '2026-04-01', '2027-03-31', true, now()
    )
    ON CONFLICT (id) DO UPDATE SET is_current = true, updated_at = now();

    -- ── Link auth account to app_users as super_admin ───────────────────
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
        SET role = 'super_admin',
            school_id = v_school_id,
            email = v_email,
            is_active = true,
            updated_at = now();

END $$;


-- ============================================================================
--  VERIFY — expect 1 row with the new school_id
-- ============================================================================
SELECT a.full_name,
       a.role,
       a.email,
       a.school_id,
       s.name AS school_name,
       (u.id IS NOT NULL) AS linked_to_auth
FROM public.app_users a
LEFT JOIN auth.users u ON u.id = a.id
LEFT JOIN public.schools s ON s.id = a.school_id
WHERE a.email = 'principal@igs.edu.pk';
