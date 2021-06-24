import confetti from 'canvas-confetti'

export default {
  colors: ['#201547', '#e40046', '#fa4616', '#ff671f', '#ff8200', '#5739c0'],

  mounted() {
    this._bind();

    this.handleEvent("start:confetti", this.onStartConfetti)
  },

  onStartConfetti() {
    let endTime = Date.now() + (5 * 1000);
    let generateConfetti = () => {
      confetti({
        particleCount: 5,
        angle: 60,
        spread: 55,
        origin: { x: 0 },
        colors: this.colors
      });
      confetti({
        particleCount: 5,
        angle: 120,
        spread: 55,
        origin: { x: 1 },
        colors: this.colors
      });

      if (Date.now() < endTime) {
        requestAnimationFrame(generateConfetti);
      }
    }

    generateConfetti()
  },

  /**
   * Bind all functions to the local instance scope.
   */
  _bind() {
    this.onStartConfetti = this.onStartConfetti.bind(this);
  }
}
