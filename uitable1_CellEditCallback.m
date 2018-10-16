function uitable1_CellEditCallback(hObject, eventdata, handles)
selectedRow = eventdata.Indices(1);
selectedCol = eventdata.Indices(2);
if selectedCol == 2
    if eventdata.NewData == 1
        handles.selectedRow = selectedRow;
    else
        handles.selectedRow = [];
    end
    guidata(hObject, handles);
end