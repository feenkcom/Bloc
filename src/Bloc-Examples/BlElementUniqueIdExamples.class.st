Class {
	#name : #BlElementUniqueIdExamples,
	#superclass : #Object,
	#traits : 'TGtExampleAssertable',
	#classTraits : 'TGtExampleAssertable classTrait',
	#category : #'Bloc-Examples'
}

{ #category : #accessing }
BlElementUniqueIdExamples >> idEqualityWithArbitraryObjectFailsGracefully [
	<gtExample>
	| id1 |
	id1 := GtInspectorInspectButtonId asBlocElementId.

	self assert: (id1 = Object new) not
]

{ #category : #accessing }
BlElementUniqueIdExamples >> idEqualityWithItself [
	<gtExample>
	| id1 |
	id1 := GtInspectorInspectButtonId asBlocElementId.

	self assert: id1 = id1
]

{ #category : #accessing }
BlElementUniqueIdExamples >> idEqualityWithSameId [
	<gtExample>
	| id1 id2 |
	id1 := GtInspectorInspectButtonId asBlocElementId.
	id2 := GtInspectorInspectButtonId asBlocElementId.

	self assert: id1 = id2
]

{ #category : #accessing }
BlElementUniqueIdExamples >> idEqualityWithSymbol [
	<gtExample>
	| id1 id2 |
	id1 := GtInspectorInspectButtonId asBlocElementId.
	id2 := #'inspector--inspect' asBlocElementId.

	self assert: id1 = id2
]
