donna = User.create(username: "d.onna", password: "josie")

allison = User.create(username: "a.llison", password: "olivia")


christmas = Occasion.create(title: "Christmas 2019", user_id: donna.id)
thanksgiving = Occasion.create(title: "Thanksgiving 2019", user_id: donna.id)
birthday = Occasion.create(title: "Birthday 2017", user_id: allison.id)

Gift.create(name: "contigo bottle", giver: "tam", category: "household", description: "really nice purple bottle with glass thermal insulator and pop open cap with double seal.", occasion_id: christmas.id)
Gift.create(name: "wine glass", giver: "kristen", category: "household", description: "wine glass with printed decorations. Came with a very nice red case topped with bow.", occasion_id: christmas.id)
Gift.create(name: "Starbucks gift card", giver: "Erika", category: "beverages", description: "$15", occasion_id: christmas.id)

Gift.create(name: "mini sugar cookies", giver: "Marcela", category: "food", description: "yummy yummy in my tummy", occasion_id: thanksgiving.id)

Gift.create(name: "pens", giver: "mary jo", category: "office", description: "gel, every color you can imagine. Because the grading never ends.", occasion_id: birthday.id)
Gift.create(name: "Starbucks gift card", giver: "ronnie", category: "beverages", description: "$20", occasion_id: birthday.id)
