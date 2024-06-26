Extension { #name : #BlRope }

{ #category : #'*Bloc-Extensions' }
BlRope >> gtLiveFor: aView [
	^ self gtTreeFor: aView
]

{ #category : #'*Bloc-Extensions' }
BlRope >> gtTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Tree';
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #'*Bloc-Extensions' }
BlRope >> paintTreeWith: view [
	view nodes
		shape: [ :each | 
			(each isKindOf: BlCollectionRope)
				ifTrue: [ BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						zIndex: 10;
						background: Color white;
						constraintsDo: [ :c | c padding: (BlInsets all: 5) ];
						text: (each from: 0 to: (100 min: each size)) ]
				ifFalse: [ | start end color |
					each isScoped
						ifTrue: [ color := Color blue.
							start := each start / each children first size * 30.
							end := each end / each children first size * 30 ]
						ifFalse: [ each isConcatenation
								ifTrue: [ color := Color red alpha: each priority.
									start := 0.
									end := each left size / each size * 30 ]
								ifFalse: [ color := Color green darker.
									start := 0.
									end := 30 ] ].
					BlElement new
						when: BlClickEvent do: [ :event | event target phlow spawnObject: each ];
						zIndex: 10;
						border: (BlBorder paint: Color black width: 1);
						size: 30 @ 10;
						layout: BlBasicLayout new;
						addChild: (BlElement new
								background: color;
								size: (end - start - 2 max: 2) @ 8;
								relocate: (start + 1) @ 1) ] ];
		with: (self withDeepCollect: #children).
	view edges
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1) ];
		connectToAll: #children.
	view layout custom: GtGraphTreeLayout new	"view layout tree 
		nodeDistance: 20;
		levelDistance: 40"
]
