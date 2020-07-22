# bigtime-api ☁️

---

Note: _Names, characters, businesses, places, events, locales, and incidents are either the products of the author's imagination or used in a fictitious manner. Any resemblance to actual persons, living or dead, or actual events is purely coincidental._ 😉

---

BigTime® Inc. is a company that thrives on selling inovative products to the general consumer market such as:

  - BigTime® BigBox: 🕰 a massive device that can give the time using a round dial
  - BigTime® BigBox Mini: ⌚️ same feature, but with a smaller form factor that can be conveniently carried on the wrist.

Those have been hits on the general consumer market. But the company CEO, _Jan-Michael van de Cloq_, wants to expand the targeted client base by including a new (strange) population: software developers.

A freshly hired product manager, let's call him _L._, has been tasked with creating an MVP of an **HTTP REST API** that will provide software developers around the world an easy way to tell time. After thourough investigations on which tech stack to use, L. has settle on going *serverless* with Amazon Web Services' [API Gateway](https://aws.amazon.com/api-gateway/) and [Lambda](https://aws.amazon.com/lambda/).

## Requirements 📝

  - API exposed using AWS API Gateway, with Lambda backend
  - CTO's a slytherin, solution should be written in Python 3 🐍
  - Single ressource `/currentTime` that can accept only `GET` requests
  - Deployment steps should be called through `make deploy`
  - Removal of deployed resources can be performed with `make destroy`
  - Ops team should be notified on backend error


Notes:
  - Assume that the team that will deploy this API has all administrative rights to do so
  - Any authentication is out of scope

#### Bonus 🥇

  - Log access to the API
  - Provide usage stats (number of times the resource has been called) for the last 15 days

## API Description 🤓

```
GET /currentTime[?tz=tzName]
```

Query parameters|Type     |Required|Description
----------------|---------|--------|----------
`tz`            |`string` | **No** |[Timezone database name](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

#### Response

```
200

Headers:
  - Content-Type: application/json

Body:
{
    "currentTime": <ISO-8601 timestamps for the selected timezone>
}
```

## Shipping the project

1) Fork this repository
2) Work on your own branch
3) Open a PR from your fork to this repository when the job's done
4) 👍
