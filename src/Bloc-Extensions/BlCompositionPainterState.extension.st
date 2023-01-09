Extension { #name : #BlCompositionPainterState }

{ #category : #'*Bloc-Extensions' }
BlCompositionPainterState >> gtCommandsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Commands';
		priority: 3;
		items: [ commands asArray reversed ];
		column: 'Type' text: [ :eachCommand | eachCommand type ] width: 100;
		column: 'By' do: [ :aColumn |
			aColumn
				stencil: [ :eachCommand |
					BrEditor new
						hMatchParent;
						vFitContent;
						aptitude: (BrGlamorousRegularEditorAptitude new);
						text: eachCommand commandString ] ];
		column: 'Offset' text: [ :eachCommand | eachCommand offset ] width: 100
]

{ #category : #'*Bloc-Extensions' }
BlCompositionPainterState >> gtOptimizedCommandsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Commands (Optimized)';
		priority: 4;
		object: [ self optimizedCopy ];
		view: #gtCommandsFor:
]
