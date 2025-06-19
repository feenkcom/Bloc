Extension { #name : #BlTheme }

{ #category : #'*Bloc-Extensions' }
BlTheme >> gtThemeChildren [
	^ self gtThemeChildrenFor: self
]

{ #category : #'*Bloc-Extensions' }
BlTheme >> gtThemeChildrenFor: anObject [
	| someSlots |
	someSlots := anObject class allSlots
			select: [ :eachSlot | eachSlot isVirtual not and: [ eachSlot name ~= #colors ] ].
	someSlots sort: [ :aSlot :bSlot | aSlot index < bSlot index ].
	^ someSlots
		collect: [ :eachSlot | eachSlot name -> (eachSlot read: anObject) ]
		thenSelect: [ :eachAssoc | 
			eachAssoc value isColor
				or: [ (eachAssoc value isKindOf: BlSubTheme)
						or: [ (eachAssoc value isKindOf: BlTheme)
								or: [ eachAssoc value className includesSubstring: 'Theme' ] ] ] ]
]

{ #category : #'*Bloc-Extensions' }
BlTheme >> gtThemeFor: aView [
	<gtView>
	^ aView tree
		title: 'Theme';
		items: [ self gtThemeChildren ];
		expandUpTo: 1;
		children: [ :anAssoc | 
			anAssoc isAssociation
				ifFalse: [ #() ]
				ifTrue: [ anAssoc value isColor
						ifTrue: [ #() ]
						ifFalse: [ (anAssoc value respondsTo: #gtThemeChildren)
								ifTrue: [ anAssoc value gtThemeChildren ]
								ifFalse: [ self gtThemeChildrenFor: anAssoc value ] ] ] ];
		itemStencil: [ :aNodeType | 
			BrHorizontalPane new
				fitContent;
				alignCenterLeft;
				addChild: (BrFrame new
						exact: 12 @ 12;
						margin: (BlInsets right: 3));
				addChild: (BrLabel new aptitude: BrGlamorousLabelAptitude) ];
		itemDataBinder: [ :anElement :anAssoc :anIndex | 
			anAssoc value isColor
				ifTrue: [ (anElement childAt: 1) background: anAssoc value ]
				ifFalse: [ (anElement childAt: 1) background: Color transparent ].
			(anElement childAt: 2) text: anAssoc key asString ];
		contextItemLabel: 'Copy name'
			action: [ :anElement :aNode | Clipboard clipboardText: aNode value key ];
		contextItemLabel: 'Copy path and name'
			action: [ :anElement :aNode | 
				Clipboard
					clipboardText: ('{1} {2}'
							format: {aNode parent value key.
									aNode value key}) ]
			if: [ :aNode | aNode value value isColor ];
		send: #value
]
