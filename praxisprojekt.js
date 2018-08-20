function runsChanged() {
    document.getElementById("run-amount").value;
    for (var i = 0; i < document.getElementById("run-amount").value; i++) {
        document.getElementById("run" + (i + 1)).style.display = "inline-block";
        document.getElementById("run-label" + (i + 1)).style.display = "inline-block";
    }

    for (var i = Number(document.getElementById("run-amount").value) + 1; i <= 10; i++) {
        document.getElementById("run" + i).style.display = "none";
        document.getElementById("run-label" + i).style.display = "none";
    }
}