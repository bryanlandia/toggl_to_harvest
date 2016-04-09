# Convert Toggl Time Entries to Harvest

This is a very simple import tool for converting Toggl http://toggl.com time
entry CSV exports to a format that you can import into Harvest
http://www.getharvest.com/

## Formats
#### Toggl CSV:

    User,Email,Client,Project,Task,Description,Billable,Start date,Start time,End date,End time,Duration,Tags,Amount (USD)
    DevDude,dev@dude.com,My Client,My Project,A Task,"A Description",No,2016-01-1,12:12:12,2016-01-1,13:24:24,01:12:12,A Tag,3.50
    DevDude,dev@dude.com,My Client,My Project,A Task,"A Description",No,2016-01-1,12:12:12,2016-01-1,13:24:24,01:12:12,A Tag,3.50

#### Generated Harvest CSV:

    date, client, project, task, note, hours, first name, last name
    2016-01-01,My Client,My Project,A Task,A Description,1.20,Dev,Dude
    2016-01-01,My Client,My Project,A Task,A Description,1.20,Dev,Dude


## Installation & Usage

```bash
git clone git://github.com/wiseleyb/toggl_to_harvest.git
cd toggl_to_harvest
```

**Syntax:** `ruby convert.rb [toggl_csv] [user_first_name] [user_last_name]`

**Example:** `ruby convert.rb toggl_entries.csv John Doe` generates `toggle_entries_harvest.csv`
