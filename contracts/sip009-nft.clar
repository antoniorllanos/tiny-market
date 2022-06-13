
;; sip009-nft
;; sip009-nft token contract

(use-trait nft-trait .sip009-nft-trait.sip009-nft-trait)

;; data and variables
(define-data-var token-id-nonce uint u0)
(define-non-fungible-token market-coin uint)
(define-data-var last-token-id uint u0)

;; constants
;;
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u1000))
(define-constant err-token-id-failure (err u1001))
(define-constant err-not-token-owner (err u1002))

;; public functions
;;
(define-read-only (get-last-token-id)
	(ok (var-get last-token-id))
)

(define-read-only (get-token-uri (token-id uint))
	(ok none)
)
(define-public (get-owner (owner-id uint))
  (ok (nft-get-owner? market-coin u1))
)

(define-public (transfer (token-id uint) (sender principal) (recipient principal))
	(begin
		(asserts! (is-eq tx-sender sender) err-not-token-owner)
		(nft-transfer? market-coin token-id sender recipient)
	)
)

(define-public (mint (recipient principal))
	(let ((token-id (+ (var-get token-id-nonce) u1)))
		(asserts! (is-eq tx-sender contract-owner) err-owner-only)
		(try! (nft-mint? market-coin token-id recipient))
		(asserts! (var-set token-id-nonce token-id) err-token-id-failure)
		(ok token-id)
	)
)