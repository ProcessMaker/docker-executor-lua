local users_api_class = require("pmsdk.api.users_api")

local host = os.getenv("API_HOST")
https, host, path = host:match("^(https?)://(.-)/(.*)$")

local users_api_instance = users_api_class.new(host, '/' .. path, {https})
users_api_instance.access_token = os.getenv('API_TOKEN')

filter=''
order_by='id'
order_direction='asc'
per_page='10'
include=''
local users, ret2, ret3 = users_api_instance:get_users(filter, order_by, order_direction, per_page, include)

return {users=users, ret2=ret2, ret3=ret3}
