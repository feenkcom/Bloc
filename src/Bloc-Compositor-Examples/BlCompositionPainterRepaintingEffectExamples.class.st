Class {
	#name : #BlCompositionPainterRepaintingEffectExamples,
	#superclass : #BlCompositionPainterRepaintingExamples,
	#category : #'Bloc-Compositor-Examples'
}

{ #category : #accessing }
BlCompositionPainterRepaintingEffectExamples >> paintFirstTime [
	<gtExample>
	| aScripter |
	
	aScripter := self scripter.
	aScripter setElement: self scripterElement.
	
	aScripter check
		label: 'Validate shadow element has a composition layer';
		satisfies: [ :anElement | anElement shadow wantsSeparateCompositingLayer ];
		playNoPulse.
	
	aScripter do
		label: 'Perform layout';
		action: [ :aSpace | aSpace doLayout ];
		onSpace;
		playNoPulse.
		
	aScripter do
		label: 'Paint space the first time';
		action: [ :theScripter |
			theScripter userData
				at: #firstRootLayer
				put: (BlCompositionPainter repaintSpace: theScripter space) ];
		onScripter;
		playNoPulse.

	aScripter do
		label: 'Clear elements that need paint';
		action: [ :aSpace | aSpace clearDirtyAreas ];
		onSpace;
		playNoPulse.

	aScripter check
		label: 'Validate shadow element wants a composition layer';
		satisfies: [ :anElement | anElement shadow hasCompositionLayer ];
		playNoPulse.
	
	^ aScripter
]

{ #category : #accessing }
BlCompositionPainterRepaintingEffectExamples >> removeShadowEffect [
	<gtExample>
	| aScripter |

	aScripter := self paintFirstTime.
	aScripter do
		label: 'Remove shadow effect from the element';
		action: [ :anElement | anElement shadow effect: BlNullEffect new ];
		playNoPulse.

	aScripter check
		label: 'Validate shadow element no longer wants a composition layer';
		satisfies: [ :anElement | anElement shadow wantsSeparateCompositingLayer not ];
		playNoPulse.

	aScripter check
		label: 'Validate shadow element no longer has a composition layer';
		satisfies: [ :anElement | anElement shadow hasCompositionLayer not ];
		playNoPulse.

	^ aScripter
]
