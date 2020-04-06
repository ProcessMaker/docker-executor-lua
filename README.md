# executor-lua
Script Task Executor Engine with LUA Runtime

This docker image provides a sandboxed protected environment to run custom LUA scripts that are written in ProcessMaker 4.
User created script tasks should be isolated however have utilities available to them in order to get most common tasks done. This 
LUA environment has modules available  so Script Tasks can take advantage of the following libraries:

- dkjson
- TODO : Identify most common libraries used for existing script tasks

## How to use
The execution requires a data.json, config.json and an output.json file be present on the host system. The data.json represents the 
Request instance data.  The config.json represents configuration specific for this Script Task. And the output.json should be a blank 
file that will be populated by the successful output of the script task. It is the responsibility of the caller to have these files 
prepared before executing the engine via command line (or docker API). The script task is represented by a script.lua file.
It is the responsibility of the caller to have these files prepared before executing the engine via command line (or docker API).

## Script Task design
When writing a Script Task, three global variables are available.  They are:

- data - A record that represents the data loaded from data.json
- config - A record that represents the config loaded from config.json
- client - The ProcessMaker 4 LUA SDK Client preconfigured to access the API via OAuth authentication

Your script should execute quickly. Once the script is complete, your return statement will be used and converted to JSON which
will be stored in the output.json file.  Once the docker execution is complete, you should the return code of the docker execution. 
If the code is 0, then the script task executed successfully and you can read output.json for the valid output.  If it is non-zero,
then you should review STDERR to see the error that was displayed during execution.

### Example data.json
```json
{
  "message": "Hello World"
}
```

### Example Script Task
```lua
-- Sample function to see if we can call it
function reverse (str)
  return str.reverse(str)
end

-- Convert our message inside our imported data and return it
data.message = reverse(data.message)

return data
```

### Example output.json
```json
{"message":"dlroW olleH"}
```

## Using the PM4 SKD

The executor comes pre-configured with the ProcessMaker 4 SDK ready to use.

Get an instance by calling `client.make('name')`.

Here is an example of fetching all pm4 users:

```lua
users_api = client.make('users_api')

filter=''
order_by='id'
order_direction='asc'
per_page='10'
include=''
local users, ret2, ret3 = users_api:get_users(filter, order_by, order_direction, per_page, include)

return {users=users}
```

See ProcessMaker API documentation for more info at /api/documentation
on your ProcessMaker 4 instance

## Command Line Usage
```bash
$ docker run -v <path to local data.json>:/opt/executor/data.json \
  -v <path to local config.json>:/opt/executor/config.json \
  -v <path to local script.lua>:/opt/executor/script.lua \
  -v <path to local output.json>:/opt/executor/output.json \
  processmaker/executor:lua \
  php /opt/executor/bootstrap.lua
```

#### License

Distributed under the [AGPL Version 3](https://www.gnu.org/licenses/agpl-3.0.en.html)

ProcessMaker \(C\) 2002 - 2020 ProcessMaker Inc.

For further information visit: [http://www.processmaker.com/](http://www.processmaker.com/)