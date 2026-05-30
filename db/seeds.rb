# données de base pour tester l'app rapidement

gm = User.find_or_create_by!(email: "gm@rpg.local") do |u|
  u.username = "GameMaster"
  u.password = "password123"
  u.role = "game_master"
end
puts "MJ : #{gm.email}"

player = User.find_or_create_by!(email: "player@rpg.local") do |u|
  u.username = "Heros"
  u.password = "password123"
  u.role = "player"
end
puts "Joueur : #{player.email}"

[
  { name: "Chapeau de mage",  slot: "hat",    hp_bonus: 5,  strength_bonus: 0, xp_multiplier: 1.2 },
  { name: "Epee rouillée",    slot: "weapon", hp_bonus: 0,  strength_bonus: 3, xp_multiplier: 1.0 },
  { name: "Bouclier en bois", slot: "shield", hp_bonus: 8,  strength_bonus: 0, xp_multiplier: 1.0 },
  { name: "Casque en fer",    slot: "hat",    hp_bonus: 10, strength_bonus: 0, xp_multiplier: 1.0 },
  { name: "Dague elfique",    slot: "weapon", hp_bonus: 0,  strength_bonus: 6, xp_multiplier: 1.1 },
].each { |a| Item.find_or_create_by!(name: a[:name]) { |i| i.assign_attributes(a) } }
puts "#{Item.count} objets"

quest = Quest.find_or_create_by!(name: "La Foret Maudite") do |q|
  q.description = "Une forêt sombre cache un ancien trésor. Ose-tu y pénétrer ?"
  q.completion_xp = 300
end

if quest.steps.empty?
  s1 = quest.steps.create!(position: 1, experience_reward: 50)
  r1 = s1.create_riddle!(question: "Qu'est-ce qui a des dents mais ne peut pas mordre ?")
  r1.answers.create!([
    { text: "Un peigne", correct: true },
    { text: "Un loup", correct: false },
    { text: "Une épée", correct: false },
    { text: "Un rocher", correct: false }
  ])
  s1.create_npc!(name: "Gobelin Forestier", hp: 25, strength: 4)

  s2 = quest.steps.create!(position: 2, experience_reward: 80)
  r2 = s2.create_riddle!(question: "Plus je sèche, plus je suis mouillée. Que suis-je ?")
  r2.answers.create!([
    { text: "Une éponge", correct: false },
    { text: "Une serviette", correct: true },
    { text: "Une pierre", correct: false },
    { text: "Un lac", correct: false }
  ])
  s2.create_npc!(name: "Troll des Bois", hp: 50, strength: 8)

  puts "quête #{quest.name} : #{quest.steps.count} étapes"
end
