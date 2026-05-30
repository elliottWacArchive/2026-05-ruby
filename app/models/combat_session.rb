class CombatSession < ApplicationRecord
  belongs_to :character
  belongs_to :npc

  validates :status, inclusion: { in: %w[ongoing won lost] }

  def log_entries
    return [] if log.blank?
    JSON.parse(log)
  rescue JSON::ParserError
    []
  end

  def add_log_entry(entry)
    entries = log_entries
    entries << entry
    update_column(:log, entries.to_json)
  end

  def player_attack!
    dmg = character.effective_strength
    self.npc_hp = [npc_hp - dmg, 0].max
    add_log_entry({ turn: "player", damage: dmg, remaining: npc_hp })
    if npc_hp <= 0
      update!(npc_hp: 0, status: "won")
    else
      npc_attack!
    end
  end

  def npc_attack!
    dmg = npc.strength
    self.character_hp = [character_hp - dmg, 0].max
    add_log_entry({ turn: "npc", damage: dmg, remaining: character_hp })
    if character_hp <= 0
      update!(character_hp: 0, status: "lost")
    else
      save!
    end
  end

  def ongoing?
    status == "ongoing"
  end

  def won?
    status == "won"
  end

  def lost?
    status == "lost"
  end
end
