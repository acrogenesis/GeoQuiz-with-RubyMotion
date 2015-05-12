class CheatActivity < Android::App::Activity
  attr_accessor :answer_is_true, :answer_text_view, :show_answer_button
  EXTRA_ANSWER_IS_TRUE = 'com.acrogenesis.geoquiz.answer_is_true'

  def onCreate(savedInstanceState)
    super
    setContentView(R::Layout::Activity_cheat)

    @answer_is_true = intent.getExtra(EXTRA_ANSWER_IS_TRUE)
    @answer_text_view = findViewById(R::Id::Answer_text_view)

    @show_answer_button = findViewById(R::Id::Show_answer_button)
    @show_answer_button.onClickListener = self
  end

  def onClick(view)
    if @answer_is_true
      @answer_text_view.text = R::String::True_button
    else
      @answer_text_view.text = R::String::False_button
    end
  end

  def self.extra_answer_is_true
    EXTRA_ANSWER_IS_TRUE
  end
end
