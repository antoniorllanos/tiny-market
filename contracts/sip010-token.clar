
;; sip010-token
;; sip010 token - contract

(use-trait nft-trait .sip010-ft-trait.sip010-ft-trait)

;; constants
;;
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u1000))

(define-fungible-token market-token)

;; SIP010 Implementation
(define-read-only (get-name)
	(ok "TinyMarket Coin")
)

(define-read-only (get-symbol)
	(ok "MFT")
)

(define-read-only (get-decimals)
	(ok u6)
)

(define-read-only (get-token-uri)
	(ok none)
)

(define-read-only (get-balance (who principal))
	(ok (ft-get-balance market-token who))
)

(define-read-only (get-total-supply)
	(ok (ft-get-supply market-token))
)

;; public functions
;;
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
	(begin
		(asserts! (is-eq tx-sender sender) err-owner-only)
		(try! (ft-transfer? market-token amount sender recipient))
		(match memo to-print (print to-print) 0x)
		(ok true)
	)
)


(define-public (mint (amount uint) (recipient principal))
	(begin
		(asserts! (is-eq tx-sender contract-owner) err-owner-only)
		(ft-mint? market-token amount recipient)
	)
)