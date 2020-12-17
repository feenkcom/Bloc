"
!Bloc

Bloc is a graphical framework that is drawing agnostic. The concrete drawing is achieved through the binding to the Sparta canvas. See ${class:BaselineOfSparta}$ for more details.

The central concept is ${class:BlElement}$.

!!Organization

The packages of Bloc are organized as follows. The visualization also shows the depended projects in gray: ${class:BaselineOfBloc|show=#gtPackagesMapFor:|expanded=true}$

!!Tutorial

You can learn Bloc following a memory game tutorial: ${icebergFile:path=feenkcom/Bloc/doc/tutorial-memory-game/00-memory-game.pillar}$.

"
Class {
	#name : #BaselineOfBloc,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfBloc
}

{ #category : #baseline }
BaselineOfBloc >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec postLoadDoIt: #'postLoadBloc:'.
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.121/src' ];
			baseline: 'BlocLayout' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.121/src' ];
			baseline: 'BlocText' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.121/src' ];
			baseline: 'Sparta' with: [
				spec repository: 'github://feenkcom/Sparta:v0.8.33/src' ];
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta:v0.8.33/src' ];
			baseline: 'TaskIt' with: [
				spec repository: 'github://feenkcom/taskit:0fd525d403c488084622c1c69ef3976be0c79f05' ];
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.16/src' ];
			baseline: 'BlocGlutin' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.121/src' ].
		spec 
			package: #'Bloc-Geometry' with: [
				spec requires: #('BlocCore' ). ];
			package: #'Bloc-Animation' with: [
				spec requires: #('BlocCore' ). ];
			package: #'Bloc-Animation-Tests' with: [
				spec requires: #(#'Bloc-Animation' 'GToolkitExamplesEngine' ). ];
			package: #'Bloc-DevTool' with: [
				spec requires: #('BlocCore' 'BlocLayout' ). ];
			package: #'Bloc-Examples' with: [
				spec requires: #('GToolkitExamplesEngine' 'BlocLayout' 'BlocText' #'Bloc-Geometry' #'Bloc-DevTool' ). ];
			package: #'BlocHost-Mock' with: [
				spec requires: #('BlocCore' ). ];
			package: #'Bloc-Compositor' with: [
				spec requires: #('BlocCore' 'SpartaSkia' ). ];
			package: #'Bloc-Sparta' with: [
				spec requires: #('BlocCore' 'BlocText' 'Sparta' #'Bloc-Compositor' ). ];
			package: #'Bloc-Exporter' with: [
				spec requires: #('BlocCore' #'Bloc-Sparta' ). ];
			package: #'Bloc-Compositor-Examples' with: [
				spec requires: #(#'Bloc-Compositor' #'Bloc-Examples' ). ];
			package: #'Bloc-Compositor-GToolkit' with: [
				spec requires: #(#'Bloc-Compositor' ). ];
			package: #'Bloc-Extensions' with: [
				spec requires: #('BlocCore' #'Bloc-Sparta' #'Bloc-Animation' #'Bloc-DevTool' ). ];
			package: 'Bloc-TaskIt' with: [
				spec requires: #('TaskIt' 'BlocCore' #'Bloc-Animation' 'BlocText' ). ];
			package: #'Bloc-Async' with: [
				spec requires: #('Bloc-TaskIt' ). ];
			package: #'Bloc-Images' with: [
				spec requires: #(#'Bloc-Async' ). ]. ].

]

{ #category : #'post load' }
BaselineOfBloc >> postLoadBloc: spec [
	(PostLoaded isNotNil and: [ PostLoaded ])
		ifTrue: [ ^ self ].
		
	PostLoaded := true.
	self postLoadDisableTaskItDebugger: spec.
	
]

{ #category : #'post load' }
BaselineOfBloc >> postLoadDisableTaskItDebugger: spec [
	(self class environment at: #TKTConfiguration) profileNamed: #gtTest.
	(self class environment at: #TKTDebugger) disable.
]
