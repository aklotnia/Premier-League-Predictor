import React from 'react'
import ClubInfoContainer from './ClubInfoContainer'
import FixtureAndStatContainer from './FixtureAndStatContainer'

class ClubPage extends React.Component {

    state = {
    }

    componentDidMount() {
        fetch(`http://localhost:3000/teams/${this.props.chosenTeam}`)
        .then(resp => resp.json())
        .then(parsed => {this.setState({clubinfo: parsed})}
        )
    }

    componentDidUpdate() {
        if (this.props.chosenTeam !== this.state.clubinfo.name) {
        fetch(`http://localhost:3000/teams/${this.props.chosenTeam}`)
        .then(resp => resp.json())
        .then(parsed => {
            if (this.state.clubinfo !== parsed) { 
                this.setState({clubinfo: parsed})
            }
        }
        )
        }
    }
    
    render() {
        return(
            <div id="ClubPageGrid">
                <ClubInfoContainer clubinfo={this.state.clubinfo}/>
                <FixtureAndStatContainer clubinfo={this.state.clubinfo}/>
            </div>
        )
    }
}

export default ClubPage