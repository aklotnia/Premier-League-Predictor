import React from 'react'
import Teamicon from '../components/Teamicon'

class Navbar extends React.Component {

    state = {

    }

    componentDidMount() {
        fetch('http://localhost:3000/teams')
        .then(resp => resp.json())
        .then(parsed => this.setState({teams: parsed}))
    }

    teamIconMounter = () => {
        if (this.state.teams) {
            return this.state.teams.map((team) => {
                if (team.name === "Huddersfield Town AFC" || team.name === "Swansea City AFC" || team.name === "Cardiff City FC" || team.name === "Fulham FC" || team.name === "West Bromwich Albion FC" || team.name === "Stoke City FC") {
                    return null
                } else {
                let keyid = Math.random()
                return <Teamicon key={keyid} teamChooser={this.props.teamChooser} team={team}/>
                }
            })
        }
    }

    mouseEnter = () => {
        this.setState({hovered: true})
    }

    mouseLeave = () => {
        this.setState({hovered: false})
    }

    render() {
    return(
        <div id="NavBarContainer">
            <nav id="Navbar">
                {this.teamIconMounter()}
            </nav>
            <div id="SubNavBar">
                <button onMouseEnter={this.mouseEnter} onMouseLeave={this.mouseLeave} id="HomeButton" onClick={this.props.goHome}>Home</button>
                <div id="HomeButtonAnimate" style={{height: this.state.hovered? '10%' : '0%'}}></div>
            </div>
        </div>
    )
    }
}

export default Navbar