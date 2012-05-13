" Common plugin functionality

" Return the character under the cursor.
function! CursorChar()
	return getline('.')[col('.') - 1]
endfunction
