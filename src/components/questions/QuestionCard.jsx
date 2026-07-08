import DifficultyBadge from '../ui/DifficultyBadge'
import OptionsList from './OptionsList'
import ExplanationPanel from './ExplanationPanel'

export default function QuestionCard({
  question,
  index,
  total,
  selected,
  correctOption,
  revealed,
  isCorrect,
  explanation,
  disabled,
  onSelect,
}) {
  return (
    <div>
      <div className="flex items-center justify-between text-sm text-slate-500">
        <span>Question {index + 1} of {total}</span>
        {question.difficulty && <DifficultyBadge difficulty={question.difficulty} />}
      </div>
      <h2 className="mt-2 text-lg font-medium text-slate-900">{question.question_text}</h2>

      <OptionsList
        question={question}
        selected={selected}
        correctOption={correctOption}
        revealed={revealed}
        disabled={disabled}
        onSelect={onSelect}
      />

      {revealed && <ExplanationPanel isCorrect={isCorrect} explanation={explanation} />}
    </div>
  )
}
