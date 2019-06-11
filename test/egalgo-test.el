;;; egalgo-test.el --- Test for egalgo

;; Copyright (C) 2019  ROCKTAKEY

;; Author: ROCKTAKEY <rocktakey@gmail.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:
(require 'ert)
(require 'egalgo)

(ert-deftest egalgo--crossover ()
  (should
   (equal
    (list '( 1  2  3 14 15 16 17 18 19 20)
          '(11 12 13  4  5  6  7  8  9 10))
    (let ((a (list  1  2  3  4  5  6  7  8  9 10))
          (b (list 11 12 13 14 15 16 17 18 19 20)))
     (egalgo--crossover 3 a b)
     (list a b))))
  (should-error
   (egalgo--crossover 0 '(1 2 3) '(4 5 6)))
  (should-error
   (egalgo--crossover -10 '(1 2 3) '(4 5 6))))

(ert-deftest egalgo--generate-genes ()
  (let ((genes (egalgo--generate-genes
                '(1 2 3 [10 20] t) 100)))
    (dolist (gene genes)
     (should
      (equal (nth 0 gene) 0))
     (should
      (or
       (equal (nth 1 gene) 0)
       (equal (nth 1 gene) 1)))
     (should
      (or
       (equal (nth 2 gene) 0)
       (equal (nth 2 gene) 1)
       (equal (nth 2 gene) 2)))
     (should
      (and (< 10 (nth 3 gene))
           (< (nth 3 gene) 20)))
     (should
      (or (eq (nth 4 gene) nil)
          (eq (nth 4 gene) t))))))

(ert-deftest egalgo-roulette-selector ()
  (let* ((genes '((1 2 3)
                  (4 5 6)
                  (7 8 9)))
         (rates '(1 4 7))
         (selected (egalgo-roulette-selector genes rates)))
    (should
     (or (equal selected '(1 2 3))
         (equal selected '(4 5 6))
         (equal selected '(7 8 9))))
    ))

(provide 'egalgo-test)
;;; egalgo-test.el ends here
