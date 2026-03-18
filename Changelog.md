# Changes to Ubuntu20-CIS-Audit

## 3.0.0

### v3_2026_March_Updates based upon CIS 3.0.0

- Fixed run_audit.sh: BENCHMARK_VER corrected from 2.2.0 to 3.0.0
- Fixed run_audit.sh: BENCHMARK_OS corrected from UBUNTU22 to UBUNTU20
- Audit role tests v3.0.0 compliant — 313/313 benchmark controls now covered
- Fixed 9 toggle variable mismatches in section 4.4 (iptables) goss tests — files referenced `ubtu20cis_rule_4_3_*` instead of `ubtu20cis_rule_4_4_*`:
  - `cis_4.4.1.3.yml`, `cis_4.4.2.1-4.yml`, `cis_4.4.3.1-4.yml`
- Fixed 3 toggle variable mismatches in existing goss test files:
  - `cis_1.1.2.6.4.yml` — referenced `rule_1_1_2_6_1` instead of `rule_1_1_2_6_4`
  - `cis_1.1.2.7.3.yml` — referenced `rule_1_1_2_7_1` instead of `rule_1_1_2_7_3`
  - `cis_5.3.3.3.3.yml` — referenced `rule_5_3_3_3_2` instead of `rule_5_3_3_3_3` (title/CIS_ID also corrected)
- Added 2 new goss test files for missing benchmark controls:
  - `cis_1.1.1.10.yml` — Ensure unused filesystems kernel modules are not available (Manual)
  - `cis_4.1.1.yml` — Ensure a single firewall configuration utility is in use (Automated)
- Added `section_4/cis_4.1/*.yml` include to `goss.yml` for new section 4.1 tests

## 2.0

### based upon CIS 2.0.1

- Rewrite and reorder of many controls.
- many new controls
- Updated var naming to be ubtu from ubuntu
- Many new variables now used

## 1.0

### Based on CIS 1.1.0

many changes and improvement
audit not set to run from /opt (can be set via variable) run_audit script
Many changes to tests to ensure working more consistently

## 0.1 initial release

- Based on CIS 1.0
