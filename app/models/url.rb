class Url < ActiveRecord::Base
  attr_accessible :original, :shortened
  validates :original, presence: true
  validates :shortened, uniqueness: true
  validates_format_of :original, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/
  
  CHARSET = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  BASE = CHARSET.size
  CODE_LENGTH = 5

  def encode
    code = ''
    id = self.id
    while id > 0
      code << CHARSET[id % BASE]
      id /= BASE
    end
    return code
  end

  def decode
    code = self.shortened.match(/http:\/\/nis.ha\/(.+)/)[1]
    id = 0
    code.each_char do |char|
      id = id * BASE + CHARSET.index(char)
    end
    return id
  end

end
