Class {
	#name : #BaselineOfBlocGlutin,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfBlocGlutin
}

{ #category : #baseline }
BaselineOfBlocGlutin >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.120/src' ];
			baseline: 'GToolkitFenster' with: [
				spec repository: 'github://feenkcom/gtoolkit-fenster:v0.8.16/src' ];
			baseline: 'Glutin' with: [
				spec repository: 'github://feenkcom/gtoolkit-glutin:v0.8.32/src' ].
		spec package: #'BlocHost-Glutin' with: [
				spec requires: #('BlocCore' 'GToolkitFenster' 'Glutin' ). ]. ].

]
