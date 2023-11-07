class Tweet < ApplicationRecord
  include ActiveModel::Validations

  has_many :retweets, -> { where is_retweet: true },
           dependent: :destroy,
           class_name: 'Tweet',
           foreign_key: 'tweet_id'

  has_many :replies, -> { where is_reply: true },
           dependent: :destroy,
           class_name: 'Tweet',
           foreign_key: 'tweet_id'

  has_many :quote_tweets, -> { where is_quote_tweet: true },
           dependent: :destroy,
           class_name: 'Tweet',
           foreign_key: 'tweet_id'

  has_many :bookmarks, dependent: :destroy

  belongs_to :tweet, optional: true

  validates :content, allow_blank: true, length: { maximum: 140, message: 'character limit of 140 exceeded!' }

  after_create :associate_with_topics

  def associate_with_topics
    # Pego todas as palavras do post em minúsculas para remover os acentos
    words = remove_accents(body.downcase).split(/\W+/)

    words.each do |word|
      # Normalizo a palavra e verifico se corresponde a algum tópico existente, ignorando maiusculas ou minusculas
      normalized_word = normalize_word(word)
      topic = Topic.where('lower(titulo) = ?', normalized_word).first

      if topic
        # Associa o post ao tópico e continua a busca
        self.topic = topic
        save
      end
    end
  end

  def remove_accents(text)
    text.gsub(/[áàâãéèêíìîóòôõúùûç]/, 'a' => 'a', 'à' => 'a', 'â' => 'a', 'ã' => 'a', 'é' => 'e', 'è' => 'e', 'ê' => 'e', 'í' => 'i', 'ì' => 'i', 'î' => 'i', 'ó' => 'o', 'ò' => 'o', 'ô' => 'o', 'õ' => 'o', 'ú' => 'u', 'ù' => 'u', 'û' => 'u', 'ç' => 'c')
  end

  def normalize_word(word)
    # Remove acentos e caracteres especiais
    word.gsub(/[^0-9a-zA-Z]/, '')
  end
end
