import Badge from './Badge'

const variantByDifficulty = {
  easy: 'success',
  medium: 'warning',
  hard: 'danger',
}

export default function DifficultyBadge({ difficulty }) {
  return (
    <Badge variant={variantByDifficulty[difficulty] ?? 'neutral'} className="capitalize">
      {difficulty}
    </Badge>
  )
}
