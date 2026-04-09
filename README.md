# Task Logs

Detailed logs for every task performed on this VM, organized by date.

## Structure

```
docs/
├── logs/           # Daily task logs (YYYY-MM-DD.md)
├── archive/        # Monthly archives (YYYY-MM.md)
├── scripts/        # Maintenance scripts
└── README.md
```

## Log Format

Each daily log file (`logs/YYYY-MM-DD.md`) contains:
- Task entries with timestamps
- Context, actions taken, and outcomes
- References to relevant files or repos

## Organization

Logs are auto-organized periodically:
- Daily logs accumulate in `logs/`
- Monthly, past logs are archived into `archive/YYYY-MM.md`
