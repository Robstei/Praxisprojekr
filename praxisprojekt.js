function runsChanged() {
    /* for (var i = 0; i < document.getElementById("run-amount").value; i++) {
        document.getElementById("run" + (i + 1)).style.display = "inline-block";
        document.getElementById("run-label" + (i + 1)).style.display = "inline-block";
    }

    for (var i = Number(document.getElementById("run-amount").value) + 1; i <= 10; i++) {
        document.getElementById("run" + i).style.display = "none";
        document.getElementById("run-label" + i).style.display = "none";
    } 

     */

    for (var i = 0; i < document.getElementById("run-amount").value; i++) {
        document.getElementById("button-run" + (i + 1)).style.display = "inline-block";
    }

    var tabs = document.getElementsByClassName("tab");
    for (var i = 0; i < tabs.length; i++) {
        tabs[i].style.display = "none";
    }
    
    document.getElementById("tab-run1").style.display = "inline-block";

    for (var i = Number(document.getElementById("run-amount").value) + 1; i <= 10; i++) {
        document.getElementById("button-run" + i).style.display = "none";
    }
}

function openRun(tab) {
    var tabs = document.getElementsByClassName("tab");

    for (var i = 0; i < tabs.length; i++) {;
        tabs[i].style.display = "none";
    }

    document.getElementById(tab).style.display = "block";
}