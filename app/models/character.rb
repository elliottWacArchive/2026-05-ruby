class Character < ApplicationRecord
  belongs_to :user
  has_many :inventories, dependent: :destroy
  has_many :items, through: :inventories
  has_many :quest_progresses, dependent: :destroy
  has_many :quests, through: :quest_progresses
  has_many :combat_sessions, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_one_attached :avatar

  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :base_hp, :base_strength, numericality: { greater_than: 0 }

  # seuil d'xp par niveau (niveau * 100)
  XP_PER_LEVEL = 100
  POINTS_PER_LEVEL = 5

  def effective_hp
    base_hp + equipped_items.sum(&:hp_bonus)
  end

  def effective_strength
    base_strength + equipped_items.sum(&:strength_bonus)
  end

  def xp_multiplier
    base = 1.0
    equipped_items.each { |i| base += (i.xp_multiplier - 1.0) }
    base
  end

  def equipped_items
    inventories.includes(:item).where(equipped: true).map(&:item)
  end

  def equipped_in_slot(slot)
    inventories.joins(:item).where(equipped: true, items: { slot: slot }).first&.item
  end

  def xp_for_next_level
    level * XP_PER_LEVEL
  end

  def add_experience(amount)
    gained = (amount * xp_multiplier).round
    self.experience += gained
    check_level_up
    save!
    gained
  end

  def current_quest_progress
    quest_progresses.find_by(status: "in_progress")
  end

  private

  def check_level_up
    while experience >= xp_for_next_level
      self.experience -= xp_for_next_level
      self.level += 1
      self.unspent_points += POINTS_PER_LEVEL
    end
  end
end
