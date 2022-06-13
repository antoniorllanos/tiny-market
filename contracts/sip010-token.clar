
;; sip010-token
;; sip010 token - contract

;; constants
;;
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u1000))

(define-fungible-token market-token)

;; public functions
;;
(define-public (mint (amount uint) (recipient principal))
	(begin
		(asserts! (is-eq tx-sender contract-owner) err-owner-only)
		(ft-mint? market-token amount recipient)
	)
)