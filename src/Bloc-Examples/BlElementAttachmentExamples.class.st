Class {
	#name : #BlElementAttachmentExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Basic'
}

{ #category : #examples }
BlElementAttachmentExamples >> addToSpace [
	<gtExample>
	<return: #BlElement>
	| aSpace aContainer aChild addedToScene removedFromScene |
	aSpace := BlSpace new.
	aChild := BlElement new.
	aChild beFocusable.

	aContainer := BlElement new.
	aContainer addChild: aChild.

	addedToScene := OrderedCollection new.
	removedFromScene := OrderedCollection new.
	aContainer
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aContainer
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].
	aChild
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aChild
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].

	self assert: aContainer isRemovedFromSceneGraph.
	self assert: aChild isRemovedFromSceneGraph.

	aSpace addChild: aContainer.

	self assert: aContainer isAttachedToSceneGraph.
	self assert: aChild isAttachedToSceneGraph.
	self
		assert: addedToScene asArray
		equals: {aContainer.
				aChild}.
	self assert: removedFromScene asArray equals: {}.

	^ aContainer
]

{ #category : #examples }
BlElementAttachmentExamples >> detachAndAttachChild [
	<gtExample>
	<return: #BlElement>
	| aContainer aChild addedToScene removedFromScene |
	aContainer := self addToSpace.
	aChild := aContainer children first.

	addedToScene := OrderedCollection new.
	removedFromScene := OrderedCollection new.
	aContainer
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aContainer
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].
	aChild
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aChild
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].

	aContainer detachChild: aChild.

	self assert: aContainer isAttachedToSceneGraph.
	self assert: aChild isDetachedFromSceneGraph.
	self assert: aChild space notNil.
	self assert: aChild parent isNil.

	self assert: addedToScene asArray equals: {}.
	self assert: removedFromScene asArray equals: {}.

	aContainer attachChild: aChild.

	self assert: aContainer isAttachedToSceneGraph.
	self assert: aChild isAttachedToSceneGraph.
	self assert: aChild space == aContainer space.
	self assert: aChild parent == aContainer.

	self assert: addedToScene asArray equals: {}.
	self assert: removedFromScene asArray equals: {}.

	^ aContainer
]

{ #category : #examples }
BlElementAttachmentExamples >> detachAndRemoveChild [
	<gtExample>
	<return: #BlElement>
	| aContainer aChild addedToScene removedFromScene |
	aContainer := self addToSpace.
	aChild := aContainer children first.

	addedToScene := OrderedCollection new.
	removedFromScene := OrderedCollection new.
	aContainer
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aContainer
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].
	aChild
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aChild
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].

	aContainer detachChild: aChild.

	self assert: aContainer isAttachedToSceneGraph.
	self assert: aChild isDetachedFromSceneGraph.
	self assert: aChild space notNil.
	self assert: aChild parent isNil.

	self assert: addedToScene asArray equals: {}.
	self assert: removedFromScene asArray equals: {}.

	aContainer removeDetachedChild: aChild.

	self assert: aContainer isAttachedToSceneGraph.
	self assert: aChild isRemovedFromSceneGraph.
	self assert: aChild space isNil.
	self assert: aChild parent isNil.

	self assert: addedToScene asArray equals: {}.
	self assert: removedFromScene asArray equals: {aChild}.

	^ aContainer
]

{ #category : #examples }
BlElementAttachmentExamples >> detachAndRemoveContainer [
	<gtExample>
	<return: #BlElement>
	| aRoot aContainer aChild addedToScene removedFromScene |
	aContainer := self addToSpace.
	aChild := aContainer children first.
	aRoot := aContainer parent.

	addedToScene := OrderedCollection new.
	removedFromScene := OrderedCollection new.
	aContainer
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aContainer
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].
	aChild
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | addedToScene add: anEvent currentTarget ].
	aChild
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | removedFromScene add: anEvent currentTarget ].

	aRoot detachChild: aContainer.

	self assert: aContainer isDetachedFromSceneGraph.
	self assert: aContainer space notNil.
	self assert: aContainer parent isNil.
	self assert: aChild isDetachedFromSceneGraph.
	self assert: aChild space notNil.
	self assert: aChild parent == aContainer.

	self assert: addedToScene asArray equals: {}.
	self assert: removedFromScene asArray equals: {}.

	aRoot removeDetachedChild: aContainer.

	self assert: aContainer isRemovedFromSceneGraph.
	self assert: aContainer space isNil.
	self assert: aContainer parent isNil.
	self assert: aChild isRemovedFromSceneGraph.
	self assert: aChild space isNil.
	self assert: aChild parent == aContainer.

	self assert: addedToScene asArray equals: {}.
	self
		assert: removedFromScene asArray
		equals: {aContainer.
				aChild}.

	^ aContainer
]

{ #category : #examples }
BlElementAttachmentExamples >> detachRequestFocusAndAttachChild [
	<gtExample>
	<return: #BlElement>
	| aContainer aChild focusEvents |
	aContainer := self addToSpace.
	aChild := aContainer children first.

	focusEvents := OrderedCollection new.
	aContainer
		when: BlFocusInEvent
		do: [ :anEvent | focusEvents add: anEvent currentTarget ].
	aChild
		when: BlFocusEvent
		do: [ :anEvent | focusEvents add: anEvent currentTarget ].

	self assert: aChild isFocused not.
	aContainer detachChild: aChild.

	aChild requestFocus.

	self assert: aContainer isAttachedToSceneGraph.
	self assert: aChild isAttachedToSceneGraph not.
	self assert: aChild isDetachedFromSceneGraph.
	self assert: aChild space notNil.
	self assert: aChild parent isNil.
	self assert: aChild isFocused.

	self assert: focusEvents asArray equals: {}.

	aContainer attachChild: aChild.

	self assert: aContainer isAttachedToSceneGraph.
	self assert: aChild isAttachedToSceneGraph.
	self assert: aChild space focusOwner equals: aChild.

	self
		assert: focusEvents asArray
		equals: {aContainer.
				aChild}.

	^ aContainer
]
