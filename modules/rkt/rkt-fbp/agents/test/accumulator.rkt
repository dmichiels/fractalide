#lang racket/base

(provide agt)

(require fractalide/modules/rkt/rkt-fbp/agent)

(define agt (define-agent
              #:input '("in")
              #:output '("out" "delete")
              #:proc (lambda (input output input-array output-array option)
                       (let* ([msg (recv (input "in"))]
                              [acc (recv (input "acc"))]
                              [step (or option 1)]
                              [sum (+ step acc)])
                         (if (= sum 3)
                             (send (output "delete") (cons 'delete #t))
                             (void))
                         (send (output "out") (cons 'set-label (string-append "button clicked : " (number->string sum))))
                         (send (output "acc") sum)))))