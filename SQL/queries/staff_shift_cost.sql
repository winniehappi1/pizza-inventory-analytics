-- =============================================================================
-- Query: Staff Shift Duration & Cost
-- File: staff_shift_cost.sql
--
-- Purpose:
--   - Calculate the number of hours worked per shift for each staff member
--   - Compute the cost of each shift based on hourly rate
--
-- Used For:
--   - Labor cost analysis
--   - Staff scheduling and budgeting
--   - Looker Studio staff cost dashboard
-- =============================================================================

SELECT
    r.date,                                     -- Date of the rota entry / shift
    s.first_name,                               -- Staff first name
    s.last_name,                                -- Staff last name
    s.hourly_rate,                              -- Staff hourly pay rate

    sh.start_time,                              -- Shift start time
    sh.end_time,                                -- Shift end time

    -- Calculate hours worked in the shift:
    -- 1. TIMEDIFF → difference between end and start time
    -- 2. Convert to minutes (hours*60 + minutes)
    -- 3. Divide by 60 to get decimal hours
    (
        (HOUR(TIMEDIFF(sh.end_time, sh.start_time)) * 60)
        + MINUTE(TIMEDIFF(sh.end_time, sh.start_time))
    ) / 60 AS hours_in_shift,

    -- Staff cost for the shift = hours worked × hourly rate
    (
        (
            (HOUR(TIMEDIFF(sh.end_time, sh.start_time)) * 60)
            + MINUTE(TIMEDIFF(sh.end_time, sh.start_time))
        ) / 60
    ) * s.hourly_rate AS staff_cost

FROM rota r
LEFT JOIN staff s 
    ON r.staff_id = s.staff_id       -- Link rota entry to staff member
LEFT JOIN shift sh 
    ON r.shift_id = sh.shift_id;     -- Link rota entry to shift definition
