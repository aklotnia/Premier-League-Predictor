import React from 'react'
import LeagueStandingsContainer from './LeagueStandingsContainer'

class LeagueTable extends React.Component {

    state = {
        width: "50%",
        expanded: false
    }

    expander = () => {
        this.setState({width: "100%", expanded: true})
    }

    reduce = () => {
        this.setState({width: "50%", expanded: false})
    }

    render() {
        return(
            <div id="LeagueTable" style={{width: this.state.width}}>
                {/* <h3>Premier League Table:</h3> */}
                <div id="LeagueTableHeader" >
                    <img id="LeagueTableImage" src="https://upload.wikimedia.org/wikipedia/en/thumb/f/f2/Premier_League_Logo.svg/1200px-Premier_League_Logo.svg.png" alt="Premier League Header"/>
                    {!this.state.expanded? <div id="ExpandArrow" onClick={this.expander}><span id="Expand">Expand</span> <img className="arrow" src="https://ya-webdesign.com/transparent250_/steps-vector-arrow-8.png" alt="ExpandArrow"/></div> : <div id="ReduceArrow" onClick={this.reduce}><img className="arrow" id="ReverseArrow" src="https://ya-webdesign.com/transparent250_/steps-vector-arrow-8.png" alt="ReduceArrow"/><span id="Expand">Reduce</span> </div>}
                </div>
                <hr id="LeagueTableBreak"/>
                <LeagueStandingsContainer />
            </div>
        )
    }
}

export default LeagueTable