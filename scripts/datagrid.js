
// These styles need to be added dynamically because we only want them
// when JS is turned on
addCss(".datagrid td.drilldown, .datagrid th.drilldown { display: none; }");

// We should only invoke datagrid actions when selection is empty
function initiateActionOnEmptySelection(actionCode, sessionString) {
    if(selectionEmpty()) {
        initiateAction(actionCode, sessionString);
        return false;
    }
}

// Keyboard
function clearNavigatableHighlight() {
    if(selectedNavigatableRowIndex != undefined) {
        var row = navigatableTableRows[selectedNavigatableRowIndex];
        if(row) {
            if(!row.hasClassName('drilled-down')) {
                row.removeClassName('hover');
            }
        } else {
            selectedNavigatableRowIndex = undefined;
        }
    }
}

function setNavigatableHighlight() {
    if(selectedNavigatableRowIndex != undefined) {
        var row = navigatableTableRows[selectedNavigatableRowIndex];
        if(row) {
            row.addClassName('hover');
        }
    }
}

function initializeNavigatableRows() {
    navigatableTableRows = $$('tr').select(function(e) { return e.readAttribute('onclick'); });
    selectedNavigatableRowIndex = undefined;
    for(var i = 0; i < navigatableTableRows.length; i++) {
        if(navigatableTableRows[i].hasClassName('drilled-down')) {
            selectedNavigatableRowIndex = i;
            break;
        }
    }
    navigatableTableRows.each(function(row) {
            Event.observe(row, 'mouseover', function(event) {
                    clearNavigatableHighlight();
                    selectedNavigatableRowIndex = undefined;
                });
        });
}

Event.observe(window, 'load', initializeNavigatableRows);

Ajax.Responders.register({
        onComplete: function() {
            clearNavigatableHighlight();
            initializeNavigatableRows();
        }
});
