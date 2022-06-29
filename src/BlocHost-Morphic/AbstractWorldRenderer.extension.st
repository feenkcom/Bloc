Extension { #name : #AbstractWorldRenderer }

{ #category : #'*BlocHost-Morphic' }
AbstractWorldRenderer class >> detectCorrectOneforWorld: aWorld [
	"Move for now to block until we move to Pharo 10, as Pharo 10 uses #detectCorrectOneForWorld:"
	| aRenderer |

	MainWorldRenderer ifNotNil: [ ^ MainWorldRenderer ].

	(self allSubclasses sorted: [ :a :b | a priority > b priority ])
		detect: [ :aClass | aClass isApplicableFor: aWorld ]
		ifFound: [ :aClass | aRenderer := aClass forWorld: aWorld ].
		
	^ MainWorldRenderer := aRenderer
]
