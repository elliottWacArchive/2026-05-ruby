module ApplicationHelper
  include ActionView::Helpers::DateHelper

  # affiche les stats d'un objet sous forme lisible
  def item_stats(item)
    parts = []
    parts << "#{item.hp_bonus > 0 ? '+' : ''}#{item.hp_bonus} PV" if item.hp_bonus.nonzero?
    parts << "#{item.strength_bonus > 0 ? '+' : ''}#{item.strength_bonus} Force" if item.strength_bonus.nonzero?
    parts << "×#{item.xp_multiplier} XP" if item.xp_multiplier != 1.0
    parts.empty? ? "Aucun bonus" : parts.join(" · ")
  end
end
