class QuizActivity < Android::App::Activity
  attr_accessor :true_button, :false_button, :next_button, :prev_button,
                :question_view, :current_index, :cheat_button
  attr_reader :question_bank

  Toast = Android::Widget::Toast
  TAG = 'QuizActivity'
  KEY_INDEX = 'index'

  def onSaveInstanceState(savedInstanceState)
    super
    savedInstanceState.putInt(KEY_INDEX, current_index)
  end

  def onCreate(savedInstanceState)
    super
    Android::Util::Log.d(TAG, 'onCreate() called')
    setContentView(R::Layout::Activity_quiz)

    @question_bank = [
      TrueFalse.new(R::String::Question_oceans, true),
      TrueFalse.new(R::String::Question_mideast, false),
      TrueFalse.new(R::String::Question_africa, false),
      TrueFalse.new(R::String::Question_americas, true),
      TrueFalse.new(R::String::Question_asia, true)
    ]
    @current_index = 0
    @current_index = savedInstanceState.getInt(KEY_INDEX, 0) unless savedInstanceState.nil?

    @question_view = findViewById(R::Id::Question_text_view)
    update_question
    @question_view.onClickListener = self

    @next_button = findViewById(R::Id::Next_button)
    @next_button.onClickListener = self

    @prev_button = findViewById(R::Id::Prev_button)
    @prev_button.onClickListener = self

    @cheat_button = findViewById(R::Id::Cheat_button)
    @cheat_button.onClickListener = self

    @true_button = findViewById(R::Id::True_button)
    @false_button = findViewById(R::Id::False_button)
    @true_button.onClickListener = @false_button.onClickListener = self
  end

  def onPause
    super
    Android::Util::Log.d(TAG, 'onPause called')
  end

  def onResume
    super
    Android::Util::Log.d(TAG, 'onResume called')
  end

  def onStop
    super
    Android::Util::Log.d(TAG, 'onStop called')
  end

  def onDestroy
    super
    Android::Util::Log.d(TAG, 'onDestroy called')
  end

  def onClick(view)
    if view == next_button || view == question_view
      self.current_index = (current_index + 1) % question_bank.length
      update_question
    elsif view == prev_button
      self.current_index = (current_index - 1) % question_bank.length
      update_question
    elsif view == cheat_button
      i = Android::Content::Intent.new(self, CheatActivity)
      answer_is_true = question_bank[current_index].true?
      i.putExtra(CheatActivity.extra_answer_is_true, answer_is_true)
      startActivity(i)
    else
      user_clicked_true = (view == true_button)
      message_id =
        if user_clicked_true == question_bank[current_index].true?
          R::String::Correct_toast
        else
          R::String::Incorrect_toast
        end
      Toast.makeText(self, message_id, Toast::LENGTH_SHORT).show
    end
  end

  private

  def update_question
    question_view.text = question_bank[current_index].question
  end
end
