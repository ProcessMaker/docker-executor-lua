users_api = client.make('users_api')

filter=''
order_by='id'
order_direction='asc'
per_page='10'
include=''
local users, ret2, ret3 = users_api:get_users(filter, order_by, order_direction, per_page, include)

return {users=users}