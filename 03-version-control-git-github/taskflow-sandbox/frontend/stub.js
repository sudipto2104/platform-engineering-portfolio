/** TaskFlow dashboard stub — Week 3 JS quality gate practice */
export function formatTaskCount(count) {
  if (typeof count !== "number") {
    throw new Error("count must be a number");
  }
  return `Tasks: ${count}`;
}