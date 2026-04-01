# Changes to Ubuntu20-CIS-Audit

## 3.0.0

### v3_2026_March_Updates based upon CIS 3.0.0

- Fixed run_audit.sh: BENCHMARK_VER corrected from 2.2.0 to 3.0.0
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
- Fixed kernel module audit paths (1.1.1.1-1.1.1.9): changed from single `/etc/modprobe.d/CIS.conf` to per-module files (`cramfs.conf`, `freevxfs.conf`, `hfs.conf`, `hfsplus.conf`, `jffs2.conf`, `overlayfs.conf`, `squashfs.conf`, `udf.conf`, `usb_storage.conf`) to match remediation
- Fixed `ubtu20cis_syslog_service` default from `journald` to `rsyslog` to match remediation defaults
- Fixed SSH config path typo in 5.1.4: `/etc/sshd/sshd_config` to `/etc/ssh/sshd_config`
- Fixed 7.1.2 audit path: was checking `/etc/passwd` (7.1.1's file) instead of `/etc/passwd-`
- Fixed cron control alignment:
  - 2.4.1.7: changed from /etc/cron.d to /etc/cron.yearly to match benchmark
  - 2.4.1.8: changed from cron restriction to /etc/cron.d permissions to match benchmark
  - 2.4.1.9: added cron.deny absence check alongside existing cron.allow check
- Added `/etc/security/opasswd.old` coverage to 7.1.10 audit (remediation covers both files)
- Fixed 5.3.3.1.3 title: "Ensure password unlock time is configured" to "Ensure password failed attempts lockout includes root account"
- Fixed 6.3.3.21 title: "Ensure the audit configuration is immutable" to "Ensure the running and on disk configuration is the same"
- Fixed 5.4.1.2 command section: CIS_ID and title incorrectly referenced 5.4.1.1
- Fixed 1.7.10 XDMCP typo: "XDCMP" to "XDMCP" (in test key and title)
- Fixed 1.4.2 title typo: "if configured" to "is configured"
- Renamed misnamed `section_3/cis_3.2/cis_3.4.3.yml` to `cis_3.2.3.yml` (content was correct for 3.2.3)
- Added missing `---` YAML document marker and blank line to 20 goss test files across sections 2–7
- Added `ubtu20cis_remote_log_server`, `ubtu20cis_remote_log_host`, `ubtu20cis_remote_log_port`, `ubtu20cis_remote_log_protocol` to `vars/CIS.yml` for goss test 6.2.3.6 remote syslog validation
- Added `ubtu20cis_xwindow_server` to `vars/CIS.yml` — goss test 2.1.20 references `.Vars.ubtu20cis_xwindow_server` but only `ubtu20cis_xwindows_required` was defined
- Converted 4 manual stub audit tests to automated assertions:
  - `cis_1.1.1.10.yml`: replaced echo stub with `/var/fs_with_cves.sh` CVE filesystem module check
  - `cis_3.1.2.yml`: replaced simple wireless directory check with modprobe blacklist-wireless.conf validation
  - `cis_6.2.1.2.yml`: replaced echo stub with `/etc/tmpfiles.d/systemd.conf` ACL check + `/var/log/journal` directory permissions check
  - `cis_6.2.3.8.yml`: replaced echo stub with `/etc/logrotate.d/rsyslog` existence and rotation settings checks

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
