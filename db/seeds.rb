# Seed data for static tables, currently only conditions

puts "Creating Conditions"
Condition.create!([
  { name: "blinded" },
  { name: "charmed" },
  { name: "deafened" },
  { name: "frightened" },
  { name: "grappled" },
  { name: "incapacitated" },
  { name: "invisible" },
  { name: "paralized" },
  { name: "petrified" },
  { name: "poisoned" }
])

puts "Created #{Condition.count} conditions"
