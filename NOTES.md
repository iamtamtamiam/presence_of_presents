
1. User
  -Has many occasions (date)
  -Username and password

2. Occasions (need user_id)
  -Has many gifts
  -Form: occasion name, date input (string)
  -Show: date, list out gifts

  -#for later, add date attribute to sort?

3. Gifts (need occasion_id)
  -Form: Name, giver,  type (category), description, thanked

  -#for later, add thanked attribute...boolean?

-------
login
  -login in page and route
  -form for log in page
  -post route
  -authenticate and redirect
-------

need to add to config.ru:  use Rack::MethodOverride
flash messages
signup - username taken?
logout


add logout on every page
homepage layout with login and logout
users page on every page after?
occasions index page for total count occasions/show
