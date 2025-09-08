/**
 * 
 */
    document.addEventListener('DOMContentLoaded', function() {
      const steps = [
        document.getElementById('payment'),
        document.getElementById('preparing'),
        document.getElementById('shipping'),
        document.getElementById('delivering'),
        document.getElementById('delivered')
      ];
      const progressLine = document.getElementById('progressLine');
      const flowClasses = [
        'flow-to-preparing',
        'flow-to-shipping',
        'flow-to-delivering',
        'flow-to-delivered'
      ];
      let current = 0;
      function activateStep(idx) {
        // 이전 단계 pulse 해제
        if (idx > 0) {
          const prevCircle = steps[idx - 1].querySelector('.status-circle');
          prevCircle.classList.remove('pulse');
        }
        // 현재 단계 활성화 및 pulse
        steps[idx].classList.add('active');
        const circle = steps[idx].querySelector('.status-circle');
        circle.classList.add('pulse');
        // 진행선 애니메이션
        if (idx > 0) {
          progressLine.classList.add(flowClasses[idx - 1]);
        }
      }
      function nextStep() {
        if (current < steps.length) {
          activateStep(current);
          current++;
          if (current < steps.length) {
            setTimeout(nextStep, 2000);
          } else {
            // 마지막 단계 pulse 3초 후 해제
            setTimeout(() => {
              const lastCircle = steps[steps.length - 1].querySelector('.status-circle');
              lastCircle.classList.remove('pulse');
            }, 3000);
          }
        }
      }
      nextStep();
    });