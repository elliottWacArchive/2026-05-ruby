class Message < ApplicationRecord
  belongs_to :npc
  belongs_to :user
  belongs_to :character

  validates :content, presence: true, length: { maximum: 500 }

  after_create_commit -> {
    broadcast_append_to(
      "npc_chat_#{npc_id}_char_#{character_id}",
      partial: "messages/message",
      locals: { message: self },
      target: "npc_chat_#{npc_id}_char_#{character_id}"
    )
  }
end
