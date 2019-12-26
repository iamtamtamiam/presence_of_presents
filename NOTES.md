
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

need to add to config.ru:  use Rack::MethodOverride 
