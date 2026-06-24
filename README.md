# debt-manager

tracking ysws debt so it doesn't spiral. login with your hack club account, link your hackatime projects, and see what you owe (or are owed) across ysws programs.

## stack

- rails 8 + postgresql
- tailwind css
- hack club oauth (hca)
- docker for prod

## running locally

```sh
cp .env.example .env
# fill in HACK_CLUB_CLIENT_ID and HACK_CLUB_CLIENT_SECRET

bin/dev  # runs rails + tailwind watcher
```

## env vars

| var | what it is |
|-----|------------|
| `HACK_CLUB_CLIENT_ID` | oauth app id from Hack Club |
| `HACK_CLUB_CLIENT_SECRET` | oauth app secret |
| `RAILS_MASTER_KEY` | copy from `config/master.key` |
| `DEBT_MANAGER_DATABASE_PASSWORD` | postgres password (prod only) |

## data model

- **user** — authenticated via hca, has a slack id + email
- **project** — belongs to a user, links to hackatime project names
- **debt** — amount owed between two users on a project, tied to a ysws program. statuses: `pending → approved / rejected / paid / canceled`