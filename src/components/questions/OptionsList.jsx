import OptionButton from './OptionButton'

const keys = ['a', 'b', 'c', 'd']

export default function OptionsList({ question, selected, correctOption, revealed, disabled, onSelect }) {
  return (
    <div className="mt-4 space-y-3">
      {keys.map((key) => (
        <OptionButton
          key={key}
          optionKey={key}
          text={question[`option_${key}`]}
          selected={selected === key}
          correct={revealed && correctOption === key}
          revealed={revealed}
          disabled={disabled}
          onClick={() => onSelect(key)}
        />
      ))}
    </div>
  )
}
