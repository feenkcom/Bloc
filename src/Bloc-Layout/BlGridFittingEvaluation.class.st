"
Snapshot of one actual feasibility solve. Failed locations are diagnostic iterates, never valid allocations. Constraints are numeric snapshots {start. end. minimum difference}; violations are evaluated at the retained iterate, not a minimal conflict explanation.
"
Class {
	#name : #BlGridFittingEvaluation,
	#superclass : #Object,
	#instVars : [
		'feasible',
		'locations',
		'constraints'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #accessing }
BlGridFittingEvaluation >> constraints [
	^ constraints
]

{ #category : #accessing }
BlGridFittingEvaluation >> feasible [
	^ feasible
]

{ #category : #initialization }
BlGridFittingEvaluation >> feasible: aBoolean locations: anArray constraints: triples [
	feasible := aBoolean.
	locations := anArray copy.
	constraints := (triples collect: #copy) asArray
]

{ #category : #'gt-views' }
BlGridFittingEvaluation >> gtConstraintsFor: aView [
	"Which inequalities are violated at the retained iterate? This is not a minimal conflict set."

	<gtView>
	^ aView columnedList
		title: 'Constraints';
		items: [ constraints ];
		column: 'From line' text: #first;
		column: 'To line' text: #second;
		column: 'Required difference' text: #third;
		column: 'Actual difference'
			text: [ :triple | (locations at: triple second + 1) - (locations at: triple first + 1) ];
		column: 'Satisfied' text: [ :triple | self satisfies: triple ]
]

{ #category : #accessing }
BlGridFittingEvaluation >> locations [
	^ locations
]

{ #category : #testing }
BlGridFittingEvaluation >> satisfies: triple [
	^ (locations at: triple second + 1) - (locations at: triple first + 1)
		>= triple third
]

{ #category : #accessing }
BlGridFittingEvaluation >> violations [
	^ constraints reject: [ :triple | self satisfies: triple ]
]
